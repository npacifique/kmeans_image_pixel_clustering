import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from PIL import Image

from flask import Flask, request, render_template, jsonify, url_for, send_from_directory
from flask_cors import CORS
import time

app = Flask(__name__)
# cors = CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})
CORS(app, resources={r"/*": {"origins": "*"}})


@app.route("/image", methods=["GET"])
def get_image():
    filename = request.args.get("filename", "")

    if filename.endswith(".svg"):
        return send_from_directory("processed", filename)

    return send_from_directory("upload", filename)


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        if request.files:
            try:
                delete_all_files(os.path.join("processed"))
                delete_all_files(os.path.join("upload"))

                response_data = predict_request_processor(request)
                return jsonify(response_data)

            except Exception as e:
                return jsonify({"error": f"Error {str(e)}"})

        else:
            return {"error": request.files}
    else:
        return {"message": "KMeans model is running..."}


def predict_request_processor(request):
    number_of_clusters = int(request.form.get("range"))

    file = request.files["file"]
    uploaded_filename = file.filename

    file_path = save_uploaded_files(file)

    model = kmeans_model_provider(file_path, n_cluster=number_of_clusters)
    colors = rgb_to_hex(model)
    pie_svg_file_name = create_pie_chart(colors)

    svg_image_url = url_for("get_image", filename=pie_svg_file_name, _external=True)
    uploaded_image_url = url_for(
        "get_image", filename=uploaded_filename, _external=True
    )

    return {
        "results": {
            "colors": colors["hex_colors"],
            "pieImageUrl": svg_image_url,
            "imageUrl": uploaded_image_url,
        }
    }


def delete_all_files(directory):
    # Get the list of files in the directory
    file_list = os.listdir(directory)

    # Iterate over the files and delete each one
    for file_name in file_list:
        file_path = os.path.join(directory, file_name)
        try:
            if os.path.isfile(file_path):
                os.remove(file_path)
                print(f"Deleted: {file_path}")
        except Exception as e:
            print(f"Error deleting {file_path}: {e}")


def kmeans_model_provider(image_path, n_cluster):
    """
    image_path: /path/to/image_name.jpg
    n_cluster: number of clusters
    Model initialization and perform prediction.
    Returns the fitted model.
    """

    # open the image and transform it to a 2D array.
    img = np.asarray(Image.open(image_path))
    shape = img.shape
    img_2d = img.reshape(shape[0] * shape[1], shape[2])

    # model initialization and fitting
    model = KMeans(n_clusters=n_cluster, n_init=1)
    model.fit(img_2d)

    return model


def rgb_to_hex(_model):
    """convert image dominate colors to hex value"""

    _colors = []

    # convert RGB the colors to hex value
    for i, color in enumerate(_model.cluster_centers_.round().astype(int)):
        _hex = ("{:02X}" * 3).format(color[0], color[1], color[2])
        _colors.append(f"#{_hex}")

    # return colors' hex value
    return {
        "hex_colors": _colors,
        "label_count": pd.DataFrame(_model.labels_).value_counts(),
    }


def create_pie_chart(colors):
    """
    This create a pie chart showing the dominant colors. The params for this method are provided by rgb_to_hex()
    hex_colors = colors['hex_colors']
    counts = colors['label_count']
    return svg's filename
    """

    hex_colors = colors["hex_colors"]
    counts = colors["label_count"]

    # plt.pie(counts, labels=hex_colors, colors=hex_colors, autopct="%1.1f%%")
    plt.pie(counts, colors=hex_colors)

    file_name = f"{np.random.randint(10, 100000000)}_{int(time.time())}.svg"
    file_path = os.path.join("processed", file_name)

    # saves the pie chart to svg
    plt.savefig(file_path)

    ## The section will allow this method to return the svg content.
    # with open(file_path, "r") as svg_file:
    #     return svg_file.read()

    return file_name


def save_uploaded_files(file):
    """Saves the uploaded file and returns the file path"""

    # set file path /folder/filename.png
    file_path = os.path.join("upload", file.filename)

    # delete the file if exist
    if os.path.exists(file_path):
        os.remove(file_path)

    # save the file
    file.save(file_path)

    # return the file path

    # Read the content of the SVG file
    return file_path
