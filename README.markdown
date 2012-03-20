http_resque
===========
http_resque helps you cleanly write integration tests for your Resque jobs. It's a thin HTTP API around the
Resque daemon. With it you can manipulate the contents of the Resque queues using HTTP requests.

This is a key ingredient for writing off-box integration tests for your background jobs. In addition to inspecting and clearing queues, you can run a Resque job _synchronously_. This allows you to test that your
background jobs are working by making HTTP requests, which is the same simple way you'd test a running webapp or a RESTful API server.

Making your background jobs easier to integration test is important -- background jobs are prone to failure
because they run in the background, and frequently have environment-related bugs in production. Unit tests
usually aren't good enough.

Installation & Usage
--------------------

    gem install http_resque

    QUEUE=* http_resque

    or if you use Bundler:
    QUEUE=* bundle exec http_resque

Optional command line arguments:

    $ http_resque -h
            -p: the port to listen on. Defaults to the $PORT environment variable, or 4568.
      --rakefile: the location of your Rakefile. The default is "./Rakefile".

When run, http_resque starts a small web server and then invokes `rake resque:work` in a fork.

REST APIs for Resque
--------------------

Once the http_resque server is started, you can access these URLs to manipulate your background jobs:

### GET /queues/:queue_name/jobs

Lists all jobs in the queue named "queue_name", oldest first.

    $ curl localhost:4568/queues/my_test_queue/jobs

    Response:
    [
      { "class" => "EmailComment", "args" => ["jack_sparrow@pirates.net"] },
      ...
    ]

### DELETE /queues/:queue_name/jobs

Deletes all jobs in the given queue.

    $ curl -X DELETE localhost:4568/queues/my_test_queue/jobs

### POST /queues/:queue_name/jobs

Create a new background job. The body of the request should be in JSON and include "class" and "arguments".

    $ curl -X POST localhost:4568/queues/my_test_queue/jobs \
         -d '{ "class": "EmailComment", "arguments":["jack_sparrow@pirates.net"] }'

### GET /queues/:queue_name/result_of_oldest_job

Runs the oldest job on the given queue, and does not return until it's finished. If there was a problem
running the job (like the job threw a Ruby exception), this will return a 500 status code with the exception
details.

    $ curl localhost:4568/queues/my_test_queue/result_of_oldest_job

    A response with a status of:
    200 if successful.
    404 if there are no jobs in this queue.
    500 if there was an error running the job.

For further details, look at the web server's code in [bin/http_resque](https://github.com/philc/http_resque/blob/master/bin/http_resque). The code is shorter than this README.

Contribute
----------
http_resque is pretty small and limited as is. If you need more CLI options or a different set of REST APIs, file an issue or send a pull request.

When editing this gem, to test your changes, you can load your local copy of the gem in your project by using this in your Gemfile:

gem "http_resque", :path => "~/path/to/http_resque"

Related
-------
[remote_http_testing](https://github.com/ooyala/remote_http_testing) - a small library for making remote HTTP requests and response assertions in tests.
