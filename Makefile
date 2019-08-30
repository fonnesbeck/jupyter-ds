.PHONY=clean image kill restart run

clean:
	docker stop jupyter-ds \
		&& docker rm jupyter-ds \
		&& docker rmi jupyter-ds

image:
	docker build -t jupyter-ds .

kill:
	docker stop jupyter-ds
	docker rm jupyter-ds

restart: kill run;

run:
	docker run -d -p 8888:8888 -p 8050:8050 \
		-v $(shell pwd)/jupyter-ds:/home/jovyan/ \
		--name jupyter-ds jupyter-ds \
		start-notebook.sh --NotebookApp.token=''
