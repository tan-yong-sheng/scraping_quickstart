import numpy as np

def handler(event, context):
    arr = np.random.randint(0,10,size=(3,3))
    return {
        "statusCode": 200, 
        "body": "Hello World", 
        "array": arr.tolist()
    }
