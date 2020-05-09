package main

import (
	"io/ioutil"
	"os"
	"os/exec"
	"testing"
)

func TestDoesExecuteSimpleDockerfile(t *testing.T) {
	// language=dockerfile
	fileText := `FROM alpine
		CMD uname`

	var err error

	err = writeFile(t, "./Dockerfile", fileText)
	if err != nil {
		return
	}

	result, err := execCommand(t, "docker", "script", ".")
	if err != nil {
		return
	}

	expectedResult := "assasa"
	actualResult := result
	assertEquals(t, expectedResult, actualResult)
}

func execCommand(t *testing.T, name string, arg ...string) (string, error) {
	var bytes []byte
	var err error

	cmd := exec.Command(name, arg...)
	err = cmd.Wait()
	if err != nil {
		t.Errorf("%s", err)
	}

	bytes, err = cmd.Output()
	if err != nil {
		t.Errorf("%s", err)
	}

	if err != nil {
		return "", err
	} else {
		return string(bytes), nil
	}
}

func assertEquals(t *testing.T, expected string, actual string) {
	if expected != actual {
		t.Errorf("expected %s, got %s", expected, actual)
	}
}

func writeFile(t *testing.T, fileName string, fileText string) error {
	err := ioutil.WriteFile(fileName, []byte(fileText), os.ModePerm)
	if err != nil {
		t.Errorf("cannot write file %s", fileName)
		t.Errorf("%s", err)
		return err
	}
	return nil
}
