import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

@connect(state => ({ uploaded: state.upload.uploaded }))
export default class UploadPreview extends PureComponent {

  static propTypes = {
    uploaded: PropTypes.object.isRequired,
  };

  render () {
    const { id, published } = this.props.uploaded;

    return (
      <div className='upload-preview'>
        Upload successful! {published ? 'Published! Congrats!' : 'Just press publish when you are ready'}
      </div>
    );
  }

}
