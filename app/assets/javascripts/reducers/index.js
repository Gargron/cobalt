import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import video from './video';
import upload from './upload';
import uploads from './uploads';

export default combineReducers({
  video,
  upload,
  uploads,
  form: formReducer
});
