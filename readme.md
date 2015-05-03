# Concurrency in Ruby

This is the public Github Repo with code snippets for my bachelor thesis at the University of Applied Sciences in Salzburg. Hopefully I'm going to finish my bachelor thesis with the title 'Concurrency Design Patterns in Ruby' in the next couple of days and when it's graded I'll open source this thesis as well.

My intend with this thesis was that concurrency in Ruby is possible even tough CRuby (MRI) has a global interpreter lock. Other implementations like Rubinius and JRuby don't have a GIL and allow true parallel coding through native threads. 

In this thesis I mainly focus on the following three design patterns:

	* Reactor Pattern
	* Actor Based Model
	* Futures

For these three patterns there are some simple reference implementations. For the reactor pattern I'm using eventmachine. 

To compare those design patterns I use a simple usecase for concurrency in ruby. 10 images should be downloaded from placehold.it. If you want to see all those design patterns in action just run:

´´
bundle install
ruby fetch_images/fetch_images.rb
´´

