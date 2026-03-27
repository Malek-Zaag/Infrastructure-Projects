exports.handler = async (event) => {
  console.log("Event: ", event);
  if (event.queryStringParameters && event.queryStringParameters.name) {
    const name = event.queryStringParameters.name;
    return {
      statusCode: 200,
      body: JSON.stringify(`Hello, ${name}! Welcome to Lambda S3 by malek!`),
    };
  } else {
    return {
      statusCode: 200,
      body: JSON.stringify("Hello from Lambda S3 by malek!"),
    };
  }
};
