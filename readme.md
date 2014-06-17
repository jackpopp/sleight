# Sleight - an MV* JS framework

Create a controller and subscribe elements to sleight
```javascript
Controller = function() {
    var self;

    self = this;
    self.testOne = sleight.sub('Hello World');
    self.testTwo = sleight.sub('Hello');
    self.testThree = sleight.sub(['one', 'two']);
    self.myFunction = function() {
      console.log('clicked');
    };
  };
```

Adding bindings to your markup (text, value, foreach, click event)
```html
<section class="binding">

	<h1 sleight-text="testOne"></h1><br>
	<input type="text" sleight-value="testOne"><br>

	<h1 sleight-text="testTwo"></h1><br>
	<input type="text" sleight-value="testTwo">

	<h1 sleight-foreach="testThree"></h1><br>

	<button sleight-click="myFunction">Button</button>

</section>
```

Create a new controller and bind to an elment
```javascript
window.controller = new Controller()
sleight.bind('.binding', controller)
```