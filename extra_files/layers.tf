resource "aws_lambda_layer_version" "numpy_layer" {
  filename   = "numpy-lambda-layer.zip"
  layer_name = "numpy-lambda-layer"

  compatible_runtimes = ["python3.9"]
}

resource "aws_lambda_layer_version" "pandas_layer" {
  filename   = "pandas-lambda-layer.zip"
  layer_name = "pandas-lambda-layer"

  compatible_runtimes = ["python3.9"]
}