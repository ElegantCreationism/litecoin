package main

import (
	"fmt"
	"os"
	"regexp"
)

func main() {
	stringInput := os.Args[1]

	a := regexp.MustCompile("[0-9]+")
	st := a.Split(stringInput, -1)

	fmt.Println(st[1])
	fmt.Println(st[2])
}

//input : "Hello! I am 1 funnyoldbat 2 chocoholic 3 team."

//output :
// funnyoldbat
// chocoholic
