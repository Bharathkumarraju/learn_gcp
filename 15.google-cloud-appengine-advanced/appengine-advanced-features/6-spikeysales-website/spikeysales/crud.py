
from spikeysales import get_model, oauth2, storage
from flask import Blueprint, current_app, redirect, render_template, request, \
    session, url_for

crud = Blueprint('crud', __name__)

def upload_image_file(file):

    if not file:
        return None

    public_url = storage.upload_file(
        file.read(),
        file.filename,
        file.content_type
    )

    current_app.logger.info(
        "Uploaded file %s as %s.", file.filename, public_url)

    return public_url


@crud.route("/")
def list():

    token = request.args.get('page_token', None)
    if token:
        token = token.encode('utf-8')

    dogs, next_page_token = get_model().list(cursor=token)

    return render_template(
        "list.html",
        dogs=dogs,
        next_page_token=next_page_token)


@crud.route("/mine")
@oauth2.required
def list_mine():
    token = request.args.get('page_token', None)
    if token:
        token = token.encode('utf-8')

    dogs, next_page_token = get_model().list_by_user(
        user_id=session['profile']['id'],
        cursor=token)

    return render_template(
        "list.html",
        dogs=dogs,
        next_page_token=next_page_token)


@crud.route('/<id>')
def view(id):
    dog = get_model().read(id)
    return render_template("view.html", dog=dog)


@crud.route('/add', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        data = request.form.to_dict(flat=True)

        image_url = upload_image_file(request.files.get('image'))

        if image_url:
            data['imageUrl'] = image_url

        if 'profile' in session:
            data['createdBy'] = session['profile']['displayName']
            data['createdById'] = session['profile']['id']

        dog = get_model().create(data)

        return redirect(url_for('.view', id=dog['id']))

    return render_template("form.html", action="Add", dog={})


@crud.route('/<id>/edit', methods=['GET', 'POST'])
def edit(id):
    dog = get_model().read(id)

    if request.method == 'POST':
        data = request.form.to_dict(flat=True)

        image_url = upload_image_file(request.files.get('image'))

        if image_url:
            data['imageUrl'] = image_url

        dog = get_model().update(data, id)

        return redirect(url_for('.view', id=dog['id']))

    return render_template("form.html", action="Edit", dog=dog)


@crud.route('/<id>/delete')
def delete(id):
    get_model().delete(id)
    return redirect(url_for('.list'))







    
