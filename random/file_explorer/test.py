import os


base_dir = './'
dir_data=[]

with os.scandir(base_dir) as ficheros:
  for fichero in ficheros:
    fichero_dict = {
      "name": fichero.name,
      "is_file": os.path.isfile(os.path.join(base_dir, fichero)),
      "style": "text"
    }
    dir_data.append(fichero_dict)
  for fichero in dir_data:
    if fichero["is_file"]:
      print(fichero["name"])
    else:
      print("* " + fichero["name"])
