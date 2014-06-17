(function() {
  this.Controller = function() {
    var self;

    self = this;
    self.testOne = sleight.sub('Hello World');
    self.testTwo = sleight.sub('Hello');
    self.testThree = sleight.sub(['one', 'two']);
    self.myFunction = function() {
      console.log('clicked');
    };
  };

}).call(this);
