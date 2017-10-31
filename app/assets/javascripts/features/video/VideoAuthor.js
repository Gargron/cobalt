import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';

export default class VideoAuthor extends PureComponent {

  static propTypes = {
    account: PropTypes.object.isRequired,
  };

  render () {
    const { account } = this.props;

    return (
      <div className='video-author'>
        <div className='video-author__icon'><img src={account.avatar} alt='' /></div>
        <div className='video-author__text'>
          <div className='video-author__text__name'>{account.display_name}</div>
          <div className='video-author__text__subscribers'>6,666 subscribers</div>
        </div>
      </div>
    );
  }
}
