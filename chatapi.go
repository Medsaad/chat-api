package main

import (
	"fmt"
	"flag"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"strconv"
	"bytes"
	"strings"
)

/* 
Types Declaration
*/
type Applications []struct {
	Name string
	Token  string   
}

type Chats []struct {
	Number  int   
}

type Messages []struct {
	Body string
	Number  int   
}


var baseUrl = "http://localhost:3000/api/v1/"



func main (){
	fmt.Println("Started Chat api ..")
	//modelType := flag.String("type", "app", "What do you want to alter? app | chat | message")
	actionType := flag.String("action", "", "What do you want to do? [action-model]  actions: [list | add | find] & models: [app | chat | message] [required]")

	token := flag.String("token", "", "Provide a token to list or create chats [required with all requests except list-app & add-app]")
	chat := flag.String("chat", "", "Provide a chat number to list or create messages [required for list-message & add-message]")

	//dependent values
	app_name := flag.String("name", "firstapp", "Provide application name [required for add-app]")
	msg_body := flag.String("body", "Hi There", "Provide message body [required for add-message]")
	keyword := flag.String("keyword", "", "Provide message search keyword [required for find-message]")

	flag.Parse()

	actSl := strings.Split(*actionType, "-")
	actType := actSl[0]
	modelType := actSl[1]
	switch modelType{
		case "app":
			if actType == "add"{
				jsonData := map[string]string{"name": *app_name}
				jsonValue, _ := json.Marshal(jsonData)
				_, err := http.Post(baseUrl + "applications.json", "application/json", bytes.NewBuffer(jsonValue))
				if err == nil{
					fmt.Println("Added New application: "+ *app_name)
				}
			}else{
				var app Applications
			
				fmt.Println("Listing Applications:")
				resp, err := http.Get(baseUrl + "applications.json")
				defer resp.Body.Close()
				
				if err != nil {
					fmt.Println("Error", err)
				}else{
					body, _ := ioutil.ReadAll(resp.Body)
					_ = json.Unmarshal(body, &app)
					//_ = json.NewDecoder(resp.Body).Decode(&app)
					for _ , element := range app{
						fmt.Println(element.Name + ": "+ element.Token)
					}
				}
			}
			
		case "chat":
			if actType == "add"{
				jsonData := map[string]string{}
				jsonValue, _ := json.Marshal(jsonData)
				_, err := http.Post(baseUrl + "applications/"+ *token +"/chats.json", "application/json", bytes.NewBuffer(jsonValue))
				if err == nil{
					fmt.Println("Added New Chat")
				}
			}else{
				var ch Chats

				fmt.Println("Listing Chats:")
				resp, err := http.Get(baseUrl + "applications/"+ *token +"/chats.json")
				defer resp.Body.Close()
				
				if err != nil {
					fmt.Println("Error", err)
				}else{
					body, _ := ioutil.ReadAll(resp.Body)
					_ = json.Unmarshal(body, &ch)
					//_ = json.NewDecoder(resp.Body).Decode(&app)
					for _ , element := range ch{
						s := strconv.Itoa(element.Number)
						fmt.Println("[Chat #"+ s +"]")
					}
				}
			}
			
		case "message":
			if actType == "add"{
				jsonData := map[string]string{"body": *msg_body}
				jsonValue, _ := json.Marshal(jsonData)
				_, err := http.Post(baseUrl + "applications/"+ *token +"/chats/"+ *chat +"/messages.json", "application/json", bytes.NewBuffer(jsonValue))
				if err == nil{
					fmt.Println("Added New Message")
				}
			}else if actType == "find"{
				var m Messages
				
				fmt.Println("Messages Search Results:")
				resp, err := http.Get(baseUrl + "applications/"+ *token +"/chats/"+ *chat +"/messages/find/"+ *keyword +".json")
				defer resp.Body.Close()
				
				
				if err != nil {
					fmt.Println("Error", err)
				}else{
					body, _ := ioutil.ReadAll(resp.Body)
					_ = json.Unmarshal(body, &m)
					//_ = json.NewDecoder(resp.Body).Decode(&app)
					fmt.Println("\n"+strconv.Itoa(len(m))+" Messages Found")
					for _ , element := range m{
						s := strconv.Itoa(element.Number)
						fmt.Println("[Message #"+ s +"]: "+ element.Body)
					}
				}
			}else{
				var m Messages
				
				fmt.Println("Listing Messages:")
				resp, err := http.Get(baseUrl + "applications/"+ *token +"/chats/"+ *chat +"/messages.json")
				defer resp.Body.Close()
				
				
				if err != nil {
					fmt.Println("Error", err)
				}else{
					body, _ := ioutil.ReadAll(resp.Body)
					_ = json.Unmarshal(body, &m)
					//_ = json.NewDecoder(resp.Body).Decode(&app)
					for _ , element := range m{
						s := strconv.Itoa(element.Number)
						fmt.Println("[Message #"+ s +"]: "+ element.Body)
					}
				}
			}
		default:
			fmt.Println("Invalid Input. please select from: add-app | list-app | add-chat | list-chat | add-message | list-message ")
	}
}