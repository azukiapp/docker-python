[azukiapp/python](http://images.azk.io/#/python)
==================

Base docker image to run **Python** applications in [`azk`](http://azk.io)

Versions (tags)
---

<versions>
- [`latest`, `3`, `3.4`, `3.4.3`, `3.4.3rc1`](https://github.com/azukiapp/docker-python/blob/master/3.4/Dockerfile)
- [`3.3`, `3.3.6`](https://github.com/azukiapp/docker-python/blob/master/3.3/Dockerfile)
- [`2`, `2.7`, `2.7.9`](https://github.com/azukiapp/docker-python/blob/master/2.7/Dockerfile)
</versions>

Image content:
---

- Ubuntu 14.04
- Git
- VIM
- Python
- pip
- Virtualenv

Database:

- PostgreSQL client
- MySQL client
- MongoDB
- SQLite3

### Usage with `azk`

Example of using this image with [azk](http://azk.io):

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  "my-app": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More images:  http://images.azk.io
    image: {"docker": "azukiapp/python"},
    // Steps to execute before running instances
    provision: [
      "pip install --user --allow-all-external -r requirements.txt"
    ],
    workdir: "/azk/#{manifest.dir}",
    shell: "/bin/bash",
    command: "python manage.py runserver 0.0.0.0:$HTTP_PORT",
    wait: {"retry": 20, "timeout": 1000},
    mounts  : {
      '/azk/#{manifest.dir}': path('.'),
      '/azk/pythonuserbase':  persistent('pythonuserbase'),
    },
    scalable: {"default": 2},
    http: {
      // my-app.dev.azk.io
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    envs: {
      // set instances variables
      PATH : '/azk/pythonuserbase/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      PYTHON_ENV : 'development',
      PYTHONUSERBASE: '/azk/pythonuserbase',
    }
  },
});
```

### Usage with `docker`

To create the image `azukiapp/python`, execute the following command on the docker-python folder:

```sh
$ docker build -t azukiapp/python 3.4/
```

To run the image and bind to port 8000:

```sh
$ docker run -it --rm --name my-app -p 8000:8000 -v "$PWD":/myapp -w /myapp azukiapp/python python server.py
```

Logs
---

```sh
# with azk
$ azk logs my-app

# with docker
$ docker logs <CONTAINER_ID>
```

## License

Azuki Dockerfiles distributed under the [Apache License](https://github.com/azukiapp/dockerfiles/blob/master/LICENSE).
