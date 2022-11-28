package main

import (
	"fmt"
	"testing"
)

func TestDoesStuff(t *testing.T) {
	t.Error("TODO")
}

func TestDoesOtherStuTestDoesOtherStu(t *testing.T) {
	if 3 != CanAddNumbers(1, 2) {
		t.Error("Failed to add some numbers")
	}
}

func TestDoesFailStill(t *testing.T) {
	fmt.Println("Showing this too?")
	if 7 != CanAddNumbers(5, 2) {
		t.Error("For some reason five always does weird stuff")
	}
}
