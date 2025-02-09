cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/flask-starter
# crete a new virtualenv
mkvirtualenv udacity_msg_3
# upgrade pip
pip install --upgrade pip

# start Flask application
pip install Flask
flask run

# retrieve app in web browser: http://localhost:5000/health

# response
#{
#  "response": "Hello World!"
#}

'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/flask-starter (master)$ flask run
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://127.0.0.1:5000
Press CTRL+C to quit
127.0.0.1 - - [08/Feb/2025 22:37:20] "GET /health HTTP/1.1" 200 -
'''
# Test applied over postman agent (https://dl-agent.pstmn.io/download/latest/win64)

# get
'''
http://localhost:5000/api/orders/computers
'''

# post
'''
http://localhost:5000/api/orders/computers

# request body in json

{
    "order_id": "1",
    "created_by": "USER14",
    "status": "QUEUED",
    "created_at": "2025-02-09T22:37:20",
    "equipment": [
        "KEYBOARD", "MOUSE"
    ]
}
'''
