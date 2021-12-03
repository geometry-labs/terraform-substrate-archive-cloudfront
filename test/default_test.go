package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
)

func TestDefault(t *testing.T) {
	t.Parallel()

	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/defaults")

	defer test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, exampleFolder)
		terraform.Destroy(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "setup", func() {
		terraformOptions := configureTerraformOptions(t, exampleFolder)
		test_structure.SaveTerraformOptions(t, exampleFolder, terraformOptions)
		terraform.InitAndApply(t, terraformOptions)
	})
}


func configureTerraformOptions(t *testing.T, exampleFolder string) *terraform.Options {
    awsRegion := "us-east-2"
	terraformOptions := &terraform.Options{
		TerraformDir: exampleFolder,
		Vars: map[string]interface{}{
			"aws_region":    awsRegion,
		},
	}
	return terraformOptions
}
