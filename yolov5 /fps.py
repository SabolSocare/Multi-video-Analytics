import time
import torch

# Load the model
model = torch.load('model.pt', map_location=torch.device('cpu'))
model.eval()

# Create a batch of input images
batch_size = 4
input_channels = 3
input_height = 224
input_width = 224
input_tensor = torch.randn(batch_size, input_channels, input_height, input_width)

# Run the model and measure the fps
num_iterations = 100
start_time = time.time()
for i in range(num_iterations):
    with torch.no_grad():
        output = model(input_tensor)
end_time = time.time()
fps = num_iterations / (end_time - start_time)
print(f'fps: {fps:.2f}')
