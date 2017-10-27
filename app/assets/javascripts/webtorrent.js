import WebTorrent from 'webtorrent/webtorrent.min';

const client = new WebTorrent();

client.on('error', err => console.error(err));

const torrents = {};

export const addTorrent = url => {
  if (torrents[url]) {
    return torrents[url];
  }

  torrents[url] = client.add(url);

  return torrents[url];
};

export default client;
