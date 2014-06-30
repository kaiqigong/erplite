class PutPolicy(object):
	scope = None
	expires = 3600
	callbackUrl = None
	callbackBody = None
	returnUrl = None
	returnBody = None
	endUser = None
	asyncOps = None

	def __init__(self, scope):
		self.scope = scope