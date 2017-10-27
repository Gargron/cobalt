import React, { PureComponent } from 'react';
import { addTorrent } from '../../webtorrent';
import classNames from 'classnames';
import PropTypes from 'prop-types';

const formatTime = secondsNum => {
  let hours   = Math.floor(secondsNum / 3600);
  let minutes = Math.floor((secondsNum - (hours * 3600)) / 60);
  let seconds = secondsNum - (hours * 3600) - (minutes * 60);

  if (hours   < 10) { hours   = "0" + hours; }
  if (minutes < 10) { minutes = "0" + minutes; }
  if (seconds < 10) { seconds = "0" + seconds; }

  return (hours === '00' ? '' : `${hours}:`) + `${minutes}:${seconds}`;
};

const findElementPosition = el => {
  let box;

  if (el.getBoundingClientRect && el.parentNode) {
    box = el.getBoundingClientRect();
  }

  if (!box) {
    return {
      left: 0,
      top: 0,
    };
  }

  const docEl = document.documentElement;
  const body  = document.body;

  const clientLeft = docEl.clientLeft || body.clientLeft || 0;
  const scrollLeft = window.pageXOffset || body.scrollLeft;
  const left       = (box.left + scrollLeft) - clientLeft;

  const clientTop = docEl.clientTop || body.clientTop || 0;
  const scrollTop = window.pageYOffset || body.scrollTop;
  const top       = (box.top + scrollTop) - clientTop;

  return {
    left: Math.round(left),
    top: Math.round(top),
  };
};

const getPointerPosition = (el, event) => {
  const position = {};
  const box = findElementPosition(el);
  const boxW = el.offsetWidth;
  const boxH = el.offsetHeight;
  const boxY = box.top;
  const boxX = box.left;

  let pageY = event.pageY;
  let pageX = event.pageX;

  if (event.changedTouches) {
    pageX = event.changedTouches[0].pageX;
    pageY = event.changedTouches[0].pageY;
  }

  position.y = Math.max(0, Math.min(1, ((boxY - pageY) + boxH) / boxH));
  position.x = Math.max(0, Math.min(1, (pageX - boxX) / boxW));

  return position;
};

export default class VideoPlayer extends PureComponent {

  static propTypes = {
    video: PropTypes.object.isRequired,
  };

  state = {
    currentTime: 0,
    duration: 0,
    paused: true,
    ready: false,
    download: 0,
    dragging: false,
  };

  componentDidMount () {
    this._setupTorrent(this.props.video.urls.torrent);
  }

  componentWillReceiveProps (nextProps) {
    if (this.props.video.urls.torrent !== nextProps.video.urls.torrent) {
      this._unbindTorrent();
      this._setupTorrent(nextProps.video.urls.torrent);
    }
  }

  componentWillUnmount () {
    this._unbindTorrent();
  }

  _unbindTorrent () {
    this.torrent.pause();
    this.torrent.removeListener('ready', this.handleTorrentReady);
    this.torrent.removeListener('download', this.handleTorrentDownload);
    this.torrent = null;
  }

  _setupTorrent (torrentUrl) {
    this.torrent = addTorrent(torrentUrl);
    this.torrent.on('ready', this.handleTorrentReady);
    this.torrent.on('download', this.handleTorrentDownload);

    if (this.torrent.ready) {
      this.torrent.resume();
      this.handleTorrentReady();
    }
  }

  handleTimeUpdate = () => {
    this.setState({
      currentTime: Math.floor(this.video.currentTime),
      duration: Math.floor(this.video.duration),
    });
  }

  handleTorrentReady = () => {
    this.setState({ ready: true });
    this.torrent.files[0].renderTo(this.video);
  }

  handleTorrentDownload = () => {
    this.setState({ download: this.torrent.progress });
  }

  handlePlay = () => {
    this.setState({ paused: false });
  }

  handlePause = () => {
    this.setState({ paused: true });
  }

  setVideoRef = c => {
    this.video = c;
  }

  setSeekRef = c => {
    this.seek = c;
  }

  handleMouseDown = e => {
    document.addEventListener('mousemove', this.handleMouseMove, true);
    document.addEventListener('mouseup', this.handleMouseUp, true);
    document.addEventListener('touchmove', this.handleMouseMove, true);
    document.addEventListener('touchend', this.handleMouseUp, true);

    this.setState({ dragging: true });
    this.video.pause();
    this.handleMouseMove(e);
  }

  handleMouseUp = () => {
    document.removeEventListener('mousemove', this.handleMouseMove, true);
    document.removeEventListener('mouseup', this.handleMouseUp, true);
    document.removeEventListener('touchmove', this.handleMouseMove, true);
    document.removeEventListener('touchend', this.handleMouseUp, true);

    this.setState({ dragging: false });
    this.video.play();
  }

  handleMouseMove = e => {
    const { x } = getPointerPosition(this.seek, e);
    const currentTime = Math.floor(this.video.duration * x);

    this.video.currentTime = currentTime;
    this.setState({ currentTime });
  }

  togglePlay = () => {
    if (this.state.paused) {
      this.video.play();
    } else {
      this.video.pause();
    }
  }

  render () {
    const { video } = this.props;
    const { paused, currentTime, duration, download, dragging } = this.state;
    const [ width, height ] = video.resolution.split('x');
    const progress = (currentTime / duration) * 100;

    return (
      <div className='video-player' style={{ width, height }}>
        <video
          ref={this.setVideoRef}
          onPlay={this.handlePlay}
          onPause={this.handlePause}
          onTimeUpdate={this.handleTimeUpdate}
          onClick={this.togglePlay}
          muted
        />

        <div className='video-player__controls'>
          <div className='video-player__seek' onMouseDown={this.handleMouseDown} ref={this.setSeekRef}>
            <div className='video-player__seek__buffer' style={{ width: `${download * 100}%` }} />
            <div className='video-player__seek__progress' style={{ width: `${progress}%` }} />

            <span
              className={classNames('video-player__seek__handle', { active: dragging })}
              tabIndex='0'
              style={{ left: `${progress}%` }}
            />
          </div>

          <div className='video-player__buttons'>
            <button onClick={this.togglePlay}><i className={paused ? 'ion-play' : 'ion-pause'} /></button>

            <span className='video-player__time-current'>{formatTime(currentTime)}</span>
            <span className='video-player__time-sep'>/</span>
            <span className='video-player__time-total'>{formatTime(duration)}</span>
          </div>
        </div>
      </div>
    );
  }

}
