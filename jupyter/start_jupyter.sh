#!/bin/bash
set -x

rm -f /home/jovyan/.jupyter/jupyter_notebook_config.py

echo 'c.NotebookApp.allow_password_change = True' > /home/jovyan/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = '/notebooks'" >> /home/jovyan/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/jovyan/.jupyter/jupyter_notebook_config.py

start-notebook.sh

