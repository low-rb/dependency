<a href="https://rubygems.org/gems/low_dependency" title="Install gem"><img src="https://badge.fury.io/rb/low_dependency.svg" alt="Gem version" height="18"></a>

# LowDependency

Automatic Dependency Injection where you get to see and keep control of the constructor.

## Injection

Inject a dependency:

```ruby
class MyClass
  include LowType

  def initialize(my_dependency: Dependency)
    @my_dependency = my_dependency # => The dependency is injected.
  end
end
```

The above example requires [LowType](https://github.com/low-rb/low_type) in order to use the `def(dependency: Dependency)` syntax.

Or you may like to use the more traditional `include` syntax:

```ruby
class MyClass
  include LowDependency[:my_dependency]

  def my_method
    @my_dependency # => The dependency is injected.
  end
end
```

This method hides and creates the constructor on your behalf.

## Providers

Provide the dependency with:
```ruby
LowDependency.provide(:my_dependency) do
  MyDependency.new
end
```

ℹ️ **Usage:** Make sure you *require* the file providing your dependencies before you define them.

## Mixing dependency types

LowDependency lets you do something quite special; mix "classical" dependency injection (passing an arg to `new`) with "provider" style dependency injection (populating an arg via framework):

```ruby
# Define both a "provider" and a "classical" dependency:
class MyClass
  include LowType

  def initialize(provider_dependency: Dependency, classical_dependency:)
    @provider_dependency = provider_dependency
    @classical_dependency = classical_dependency
  end
end

# Now bring it all together by calling:
MyClass.new(classical_dependency: ClassicalDependency.new)
```

The `provider_dependency` argument will automatically be injected by LowDependency!

Now you get to have your classical dependency cake 🍰 and eat it too with an automatically injected dependency spoon! 🥣

## Installation

Add `gem 'low_dependency'` to your Gemfile then:
```
bundle install
```
