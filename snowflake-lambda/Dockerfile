FROM public.ecr.aws/lambda/python:3.9

# Install dependencies system-wide (not in /var/task)
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy function code to Lambda's expected location
COPY app/app.py ${LAMBDA_TASK_ROOT}

# Set the handler (matches your Python file and function)
CMD ["app.lambda_handler"]
