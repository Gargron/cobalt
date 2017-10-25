import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { Field, reduxForm, formValues, change } from 'redux-form';
import { connect } from 'react-redux';
import { uploadVideo, publishUploadedVideo } from '../../actions';
import Dropzone from 'react-dropzone';
import UploadProgress from './UploadProgress';
import UploadPreview from './UploadPreview';

const mapStateToProps = state => ({
  uploaded: state.upload.uploaded,
  uploading: state.upload.uploading,
});

const mapDispatchToProps = dispatch => ({
  onDrop: files => dispatch(uploadVideo(files[0])),
  onSubmit: values => dispatch(publishUploadedVideo(values)),
});

@connect(mapStateToProps, mapDispatchToProps)
@reduxForm({ form: 'upload' })
export default class Upload extends Component {

  static propTypes = {
    handleSubmit: PropTypes.func.isRequired,
    uploaded: PropTypes.oneOfType([PropTypes.bool, PropTypes.object]).isRequired,
    uploading: PropTypes.bool.isRequired,
    onDrop: PropTypes.func.isRequired,
  };

  render () {
    const { uploaded, uploading, progress, onDrop, handleSubmit } = this.props;

    if (uploaded || uploading) {
      return (
        <div className='upload'>
          {uploading && <UploadProgress />}
          {uploaded && <UploadPreview />}

          <form className='upload__form' onSubmit={handleSubmit}>
            <div className='upload__form__sidebar'>
              {uploaded && <div className='upload__form__thumbnail'><img src={uploaded.urls.thumbnail} alt='' /></div>}
            </div>

            <div className='upload__form__fields'>
              <div className='upload__form__field'>
                <Field name='title' component='input' type='text' placeholder='Title' />
              </div>

              <div className='upload__form__field'>
                <Field name='description' component='textarea' placeholder='Description' />
              </div>

              <div className='upload__form__actions'>
                <button type='submit'>{uploaded && uploaded.published ? 'Save changes' : 'Publish'}</button>
              </div>
            </div>
          </form>
        </div>
      );
    } else {
      return (
        <div className='upload'>
          <Dropzone className='upload__dropzone' style={{}} accept='video/*' multiple={false} onDrop={onDrop}>
            <div className='upload__dropzone__label'>
              <i className='ion-upload' />
              <h1>Select file to upload</h1>
              <p>Or drag and drop a video file</p>
            </div>
          </Dropzone>
        </div>
      );
    }
  }

}
