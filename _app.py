# from flask import Flask
# from flask import render_template
# from joblib import dump, load

# from PIL import Image
# from sklearn.cluster import KMeans
# from sklearn.preprocessing import StandardScaler
# from PIL import Image


# import matplotlib.pyplot as plt
# import os


# app = Flask(__name__)

# model_path = os.path.join(os.path.dirname(__file__), "models", "create_model.joblib")


# @app.route("/", methods=["GET", "POST"])
# def hello_world():
#     model = Initialize_model(model_path, "xx", 1)
#     
#     return render_template("index.html", title=title)


# # convert image dominate colors to hex value
# def rgb_to_hex(_model):
#     _colors = []
#     for i, color in enumerate(_model.cluster_centers_.round().astype(int)):
#         _hex = ("{:02X}" * 3).format(color[0], color[1], color[2])
#         _colors.append(f"#{_hex}")
#     return _colors


# def create_pie_chart(labels_count, hex_colors):
#     plt.pie(labels_count, labels=hex_colors, colors=hex_colors, autopct="%1.1f%%")
#     plt.savefig("color_pi_charttest.svg")
#     plt.show()


# def Initialize_model(path, number_of_clusters, image_path):
#     # create_2d_image = load(model_path)
#     print(load("example.joblib"))

#     # model = load(path)
#     # img_2d = create_2d_image(image_path)

#     # create_model = joblib.load("create_model.joblib")
#     # model = create_model(img_2d, number_of_clusters)
#     return 10
