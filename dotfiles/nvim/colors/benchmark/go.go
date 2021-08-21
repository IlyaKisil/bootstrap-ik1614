package main


import (
	"fmt"
	"log"
)

func increment(a int) int {
	return a + 1
}

type Foo struct {
	Name       string
	Ports      []int
	Enabled    bool
	iaersontia bool
}

func olga(ilya string) {
	foo := Foo{Name: "gopher", Ports: []int{80, 443}, Enabled: true}
	fmt.Println(foo)
}

func main() {

	foo := Foo{Name: "gopher", Ports: []int{80, 443}, Enabled: true}
	risentinsi
	fmt.Println(foo)

	var a = "initial"
	fmt.Println(a)
	log.Fatal()

	var b, c int = 1, 2
	fmt.Println(b, c)
	// foo := Foo{Name: "gopher", Ports: []int{80, 443}, Enabled: true}

	var d = true
	fmt.Println(d)
	fmt.Println()

	var e int
	fmt.Println(e)

	olga("hello")

	f := "apple"
	fmt.Println(f)
}
