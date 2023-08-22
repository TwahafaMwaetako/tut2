import ballerina/http;

configurable int port = 9090;

 type Person readonly & record {|
  string id;
  string name;
 |};
 
  table<Person> key(id) group = table [
  {id: "1", name: "Jonathan Pikes"}, 
  {id: "2", name: "Vincent Foster"}, 
  {id: "3", name: "Sarah Tommy Robson"}
  ];
  
service / on new http:Listener(port) {

 resource function get people() returns Person[] {
 return group.toArray();
}

resource function get people/[string id]() returns Person|http:NotFound {
 Person? a_person = group[id];
 if a_person is () {
      return http:NOT_FOUND;
 
 } else {
      return a_person;
 
 }
}

resource function post people(@http:Payload Person new_person) returns http:Response {
 group.add(new_person);
 http:Response post_resp = new;
 post_resp.statusCode = http:STATUS_CREATED;
 post_resp.setPayload({id: new_person?.id});
 return post_resp;
}

}
