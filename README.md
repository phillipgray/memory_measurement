# README

## Intro and Summary

This is a dummy Rails app built to see if it's possible to measure the amount of memory being used for retrieving different sized JSON blobs from the db. In this case, I inspect and puts the data to the console as a basic set of operations on some chunk of data. There's also some commented out code for doing an in-memory sort in case that's a better approximation for real work.

## Usage

To bootstrap:

- Clone the repo
- Copy sample json data file to project root
- Run `rails db:setup`

I've built a simple test harness rake task, which takes a Ruby object that implements a single class method `::call` and measures the memory usage of the application while running that method. These test ruby objects live in `lib/`. There is also a control object, which runs a database query that returns no results, requiring no in-memory operations on queried records.

The rake task can be run with a test file like this:

`rails memory_usage:measure[name_of_ruby_file_with_no_extension]`

Note: if you're using a zsh shell, you'll have to escape the square brackets.

The app expects there to be a valid JSON file named `fin_data_sample2.json` in the application root in order to seed the database with sample data. You can change the name or location of this file in `db/seeds.rb`.

## Background

I'm using a gem called `memory_profiler` to measure how much memory the application is using when retrieving and manipulating large JSON payloads from the database.

Allocated memory is a measure of all memory and object allocation during execution of a given block. Retained memory is a measure of long-lasting memory and object allocation.

Our sample json is sized as follows:
Scoped single blob: single object, 65 keys with each value as three element hash
Whole single blob: 39 objects, 8736 total keys with each value as three element hash

## Results

Memory usage on a local machine (average with n=3):

- Control query
  - Total allocated: 9.139 MB
  - Total retained:  0.690 MB

- Scoped single blob
  - Total allocated: 9.847 MB
  - Total retained:  0.786 MB

- Whole single blob
  - Total allocated: 28.731 MB
  - Total retained:  0.788 MB

## Discussion

It appears that the amount of retained memory does not change between scoped and single blob calculations, so I'm leaving that out of the discussion. Similarly, the difference in memory usage for a small blob and the control (where no records are loaded into memory) is about 8%

There is however a notable difference (292%) between the total memory usage for a scoped (small) JSON blob/payload and a whole JSON blob. And it's important to note that this blob represents a query for a single year for a single company. It seems probable that increasing the scope of the query would significantly increase the memory demands per query/operation.

This also does not take into account the horizontal scaling that would likely occur with concurrent web requests. If a server is working on 10 requests concurrently, then theoretically we've increased our memory demands by an order of magnitude.

It appears that scoping the size of the query made to the database would have a quantifiable and significant effect on the memory usage of an application needing to do operations on a JSON payload.

