# Ada TaskList API

This is an API to go along with the Backbone live-code.

## Installing / Running

```bash
$ git clone <git-uri.git>
$ cd ada-tasklist-api
$ bundle install
$ rake db:reset
$ rails s
```

Then go to `http://localhost:3000/tasks`. You should see some JSON.

## API Description

```
GET /tasks
  Get all tasks
  Response body:
    {
      count: <number>,
      tasks: [
        {
          id: <number>,
          title: <string>,
          description: <string>,
          completed: <boolean>
        }, ...
      ]
    }

POST /tasks
  Create a new task
  Request body:
    {
      task: {
        title: <string>,
        description: <string>,
        completed: <boolean>
      }
    }
  Response body:
    A list of errors on failure, or
    {
      id: <number>
    }

GET /tasks/<id>
  Get a single task
  Response body:
    {
      id: <number>,
      title: <string>,
      description: <string>,
      completed: <boolean>
    }

PUT /tasks/<id>
  Modify a task
  Request body:
    {
      task: {
        title: <string>,
        description: <string>,
        completed: <boolean>
      }
    }
  Response body:
    None on success, or a list of errors on failure

DELETE /tasks/<id>
  Delete a task
```
