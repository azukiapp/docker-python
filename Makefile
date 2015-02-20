# `adocker` is alias to `azk docker`
all:
	# latest
	adocker build -t azukiapp/python           ./3.4

	# version tagged
	adocker build -t azukiapp/python:2.7       ./2.7
	adocker build -t azukiapp/python:3.3       ./3.3

--no-cache:
	# latest
	adocker build --rm --no-cache -t azukiapp/python           ./3.4

	# version tagged
	adocker build --rm --no-cache -t azukiapp/python:2.7       ./2.7
	adocker build --rm --no-cache -t azukiapp/python:3.3       ./3.3
