import ballerina/io;
import ballerina/http;

type person readonly & record {|
    string id;
    string name;

|};


public function main() returns error?{

    http:Client peopleClient = check new("localhost:9090");
    person []people= check peopleClient->get("/people");
    // Person[] person = check peopleClient->/people;
    io:println("Response from the server",people.toJsonString());

     http:Response resp = check peopleClient->/poeple.post({id: "6", name: "Ndagwana Nahshandi"});
    if (resp.statusCode == 201) {
        io:println(" \n The post request succesful ", resp.getJsonPayload(), "record added");
    }

    io:println("Specific record  ");
    string id = "2";
    //   http:Response a_person = check peopleClient->get("/people/"+id);
    person a_person = check peopleClient->get("/people/" + id);

    io:println("Get Request", a_person.toString());
}
