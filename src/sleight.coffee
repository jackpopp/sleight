Observer = (value, subscribers) ->

	val = value

	Observer.prototype.bserver = ->
		if arguments.length is 0
			return val
		else
			val = arguments[0]
			# need to notify the subscribers
		return

	return this.bserver

class Subscription
	constructor: (@observer) ->

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

	# create a new observer object and attacj it to a subscriber

	sub: (val) ->
		observer = new Observer(val)
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
				if bindings.indexOf(attr.name.replace(name, '')) > -1
					# evaluate controllers to find a 
					for controller in @controllers
						for key, value of controller
							if key is attr.value
								element.innerHTML = value()				
		return

@sleight = new Sleight()