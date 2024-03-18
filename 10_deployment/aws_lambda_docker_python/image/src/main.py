import json

def handler(event, context):
    print('requests: {}'.format(json.dumps(event)))
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'text/plain'
        },
        'body': 'Hello, CDK! You have hit {path}\n {querystring}\n'.format(path = event['path'], 
                    querystring = event["queryStringParameters"])
    }