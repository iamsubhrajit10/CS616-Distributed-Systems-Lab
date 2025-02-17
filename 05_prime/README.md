# Prime number finder

## Introduction

Your task will be to implement a distributed system that will find large primes. The system should have one server that is in control of the computation and a dynamic set of workers that are assigned numbers to test for primality.

## The tasks are

1. **Finding a prime**: Write a simple C/Python/Go (any language) function to test whether a number is prime. If you are not interested in writing your function, you can also search on Google or Github and reuse the code. Please acknowledge the authors appropriately so that we do not break a licensing/compliance law.

2. **The server**: We should implement a server that keeps track of the highest prime number found so far and the number next in turn to examine. The server should accept requests from workers and hand out numbers that should be examined.  If the workers can determine that it is a prime number, it will return to the server. In this phase, we will not handle the situation where workers accept a number and then dies nor workers that are malicious and report prime numbers without proper checking.

3. **Speed it up**: There are two ways to speed up the process. One is to implement
a more efficient prime test function on the worker. Another is to do part of the prime checking on the server before delegating a number to a worker. How much should be done on the server? We don’t want the server to spend its time doing pre-checking of numbers if the workers are idle. At the same time replying to a request takes time, so we should reduce the number of requests as much as possible.  What’s the bottleneck in our system: the number of workers, the server, or the fact that we’re communicating over a shared network? Does this
change as numbers get larger?

4. **Making it robust**: How can we handle the situation with dying workers? Can we have redundancy in the system so dead workers are detected and the assigned number is given to another worker?  Can we handle malicious workers? Should we send all numbers to more than one worker? Is it more important to find all numbers or make sure that reported primes are prime?

## Deliverables

1. **Source Code**:
   - The complete source code for the server and worker implementations.
   - The prime test function in C/Python/Go (any language).

2. **Report**:
    - A brief description about the implementation of the prime test function, server, and worker (and optimizations if any).
    - Any configuration files required to run the server and worker programs.
    - Instructions on how to configure and run the system.
