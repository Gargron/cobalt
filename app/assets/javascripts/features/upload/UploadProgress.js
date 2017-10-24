import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Motion, spring } from 'react-motion';

@connect(state => ({ progress: state.upload.progress }))
export default class UploadProgress extends PureComponent {

  static propTypes = {
    progress: PropTypes.number.isRequired,
  };

  render () {
    const { progress } = this.props;

    return (
      <Motion defaultStyle={{ width: 0 }} style={{ width: spring(progress) }}>
        {({ width }) => (
          <div className='upload-progress'>
            <div className='upload-progress__progress' style={{ width: `${width}%` }} />
            <div className='upload-progress__label'>Uploading {progress}%...</div>
          </div>
        )}
      </Motion>
    );
  }

}
