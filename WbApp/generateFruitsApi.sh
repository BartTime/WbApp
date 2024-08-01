
MODULE="Modules/FruitApi/Sources/FruitApi/"

openapi-generator generate -i "fruitapi.yaml" -g swift5 -o "fruitapi"
rm -r $MODULE""*
cp -R "fruitapi/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "fruitapi"
