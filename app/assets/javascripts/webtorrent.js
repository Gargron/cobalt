import WebTorrent from 'webtorrent/webtorrent.min';

const client = new WebTorrent();

client.on('error', err => console.error(err));

export default client;
