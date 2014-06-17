# Sleight - an MV* JS framework

Create a controller and subscribe elements to sleight
```javascript
Controller = function() {
    var self;

    self = this;
    self.testOne = sleight.sub('Hello World');
    self.testTwo = sleight.sub('Hello');
    self.testThree = sleight.sub(['one', 'two']);
  };
```

Adding bindings to your markup (text, value, foreach)
```html
<section class="binding">

	<h1 sleight-text="testOne"></h1><br>
	<input type="text" sleight-value="testOne"><br>

	<h1 sleight-text="testTwo"></h1><br>
	<input type="text" sleight-value="testTwo">

	<h1 sleight-foreach="testThree"></h1><br>

</section>
```

Create a new controller and bind to an elment
```javascript
window.controller = new Controller()
sleight.bind('.binding', controller)
```