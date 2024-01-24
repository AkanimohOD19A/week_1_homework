# base Docker image that we will build on
FROM python:3.9

# set up our image by installing prerequisites; pandas in this case
RUN pip list

ENTRYPOINT [ "bash" ]

# -- docker build -t my_image .
# -- docker run -it my_image .
