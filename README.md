<a href="https://rubygems.org/gems/low_dependency" title="Install gem"><img src="https://badge.fury.io/rb/low_dependency.svg" alt="Gem version" height="18"></a>

# LowDependency

Dependency Injection where you get to keep control of the constructor.

## Injection

Inject a dependency:

```ruby
class MyClass
  def initialize(my_dependency: Dependency)
    my_dependency # => The dependency is injected.
  end
end
```

The above example requires [LowType](https://github.com/low-rb/low_type) in order to use the `def(dependency: Dependency)` syntax.  
Or you may like to use the more traditional `include` syntax (which hides and creates the constructor):

```ruby
class MyClass
  include LowDependency[:my_dependency]

  def my_method
    my_dependency # => The dependency is injected.
  end
end
```

## Providers

Provide the dependency with:
```ruby
LowDependency.provide(:my_dependency) do
  MyDependency.new
end
```

ℹ️ **Note:** Make sure you *require* the file providing your dependencies before you define them.

## Mixed dependencies

Dependency lets you mix "classical" dependency injection (passing an arg to a `new` method) with "provider" style dependency injection (populating an arg via a framework):

```ruby
# Define both a "provider" and a "classical" dependency:
class MyClass
  def initialize(provider_dependency: Dependency, classical_dependency:)
    @provider_dependency = provider_dependency
    @classical_dependency = classical_dependency
  end
end

# Now bring it all together by calling:
MyClass.new(classical_dependency: ClassicalDependency.new)
```

In the example above `provider_dependency` will automatically be injected by Dependency.

## Installation

Add `gem 'low_dependency'` to your Gemfile then:
```
bundle install
```
