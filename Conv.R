install.packages("keras")
install.packages("tensorflow")
library(keras)
library(tensorflow)

install_tensorflow(version = "gpu")
 
data<-dataset_cifar10()
class_names <- c('airplane', 'automobile', 'bird', 'cat', 'deer',
                 'dog', 'frog', 'horse', 'ship', 'truck')

model <- keras_model_sequential()%>%
  layer_conv_2d(filters = 32, kernel_size = c(4,4), activation = "relu", 
                input_shape = c(32,32,3)) %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 64, kernel_size = c(4,4), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 64, kernel_size = c(4,4), activation = "relu")%>%
  layer_flatten() %>% 
  layer_dense(units = 64, activation = "relu") %>% 
  layer_dense(units = 10, activation = "softmax")

model %>% compile(
  optimizer = "adam",
  loss = "sparse_categorical_crossentropy",
  metrics = "accuracy"
)

history <- model %>% 
  fit(
    x = data$train$x, y = data$train$y,
    epochs = 50,
    validation_data = unname(data$test),
    verbose = 2
  )
