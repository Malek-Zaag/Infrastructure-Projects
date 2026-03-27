export const handler = async (event) => {
    console.log("Event: ", event);
    return {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda V2 by malek!'),
    };
}

function main(){
    console.log("Hello from main function!");
}

main();