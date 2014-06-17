Observer = (value, subscribers) ->
	self = @
	val = value
	subscribers = subscribers

	this.getSubscribers = ->
		return subscribers.elements

	this.notifySubscribers = ->
		for obj in subscribers.elements
			sleight.updateElement(obj.element, self, obj.type)
		return

	this.attachSubscriber = (element, type) ->
		subscribers.elements.push {element: element, type: type}
		return

	this.value = ->
		if arguments.length is 0
			return val
		else
			val = arguments[0]
			# need to notify the subscribers
			self.notifySubscribers()
		return

	return self

class Subscription
	constructor: ->
		@elements = []

class Sleight
	constructor: ->
		@elements = []
		@subscriptions = []
		@observers = []
		@controllers = []
		return

	name = 'sleight-'

	bindings = [
		'text',
		'click',
		'foreach',
		'value'
	]

	# create a new observer object and attach it to a subscriber

	sub: (val) ->
		subscriber = new Subscription()
		@subscriptions.push(subscriber)
		observer = new Observer(val, subscriber)
		@observers.push observer
		return observer

	pub: ->
		return

	# bind to an element

	bind: (elem, controller) ->
		element = document.querySelectorAll(elem)

		if element.length is 0
			throw new Error('No element found')

		if element.length > 1
			throw new Error('Cannot bind to multiple instances of element')

		@controllers.push controller

		@elements.push element[0]
		@parse(element[0].children)
		return

	# parses an element html
	# register bindings against a controller

	parse: (elements) ->
		for element in elements
			for attr in element.attributes
				bindingType = attr.name.replace(name, '')
				if bindings.indexOf(bindingType) > -1
					# evaluate controllers to find a 
					for controller in @controllers
						for key, prop of controller
							if key is attr.value
								@handleBinding(element, prop, bindingType)			
		return

	handleBinding: (element, prop, bindingType) ->
		prop.attachSubscriber(element, bindingType)

		# set events
		@updateElement(element, prop, bindingType)

		# set event handlers
		switch bindingType
			when 'value'
				element.addEventListener 'keyup', 
					do (prop) ->
						(elem) -> 
							prop.value(elem.target.value) 
			when 'click'
				console.log 'register handler'
		return

	updateElement: (element, prop, bindingType) ->
		switch bindingType
			when 'text' 
				element.innerHTML = prop.value()
			when 'value'
				element.value = prop.value()
			when 'foreach'
				array = []
				temp = null
				for obj in prop.value()
					temp = element
					temp.innerHTML = obj
					array.push temp.outerHTML
				element.innerHTML = array.join('')
		return



@sleight = new Sleight()