import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import video from './video';
import upload from './upload';

export default combineReducers({
  video,
  upload,
  form: formReducer
});
