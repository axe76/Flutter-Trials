import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode(); //allows focus scope to access this node when user does something in the app for forms
  final _descriptFocusNode = FocusNode(); 
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>(); //Interacts with the state of the form
  var _editedProduct = Product(
    id: null,
    description: '',
    imageUrl: '',
    price: 0,
    title: '',
  ); 

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit){
      final prodId = ModalRoute.of(context).settings.arguments as String;
      if(prodId != null){
        final productToBeEdited = Provider.of<ProductsProvider>(context, listen: false).findById(prodId);
        _editedProduct = productToBeEdited;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': ''
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {//dispose of the focus nodes when state is cleared, i.e. when screen is closed
    _imageUrlFocusNode.removeListener(updateImageUrl);
    _priceFocusNode.dispose();
    _descriptFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {
      });
    }
  }

  void _saveForm(){
    final isValid = _form.currentState.validate(); //calls all validators and returns false if even one fails
    if(!isValid){
      return;
    }
    _form.currentState.save();

    if(_editedProduct.id !=null){//i.e. we have recieved id as argument in did change dep, i.e. we are editing and not adding a prod
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    }else{
      Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
    // print(_editedProduct.title);
    // print(_editedProduct.description);
    // print(_editedProduct.price);
    // print(_editedProduct.imageUrl);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Item'),
      actions: [
        IconButton(icon: Icon(Icons.save),
        onPressed: _saveForm,
        )
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title',),
                textInputAction: TextInputAction.next,
                validator: (value){//value is the stuff entered in form
                  if(value.isEmpty){
                    return 'Please enter a title'; //error text
                  }
                  return null; //null means correct
                },
                onFieldSubmitted: (value){
                  FocusScope.of(context).requestFocus(_priceFocusNode); //Jumps to this focus node
                },
                onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id, 
                    isFavourite: _editedProduct.isFavourite,
                    description: _editedProduct.description, 
                    title: value, 
                    price: _editedProduct.price, 
                    imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price',),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode, //Focus Node allows user to come here on pressing the submit button in above text form
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter a price';
                  }
                  if(double.tryParse(value)==null){
                    return 'Please enter a valid price';
                  }
                  if(double.parse(value)<=0){
                    return 'Please enter a number greater than 0';
                  }
                  return null;
                },
                onFieldSubmitted: (val){
                  FocusScope.of(context).requestFocus(_descriptFocusNode); //Jumps to this focus node
                },
                onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id, 
                    isFavourite: _editedProduct.isFavourite,
                    description: _editedProduct.description, 
                    title: _editedProduct.title, 
                    price: double.parse(value), 
                    imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description',),
                maxLines: 3,
                keyboardType: TextInputType.multiline, //here no TextINputActionType.next as multiline will mean on keyboard enter button is present instead of submit button
                focusNode: _descriptFocusNode,
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter a desription';
                  }
                  if(value.length<10){
                    return 'Please enter atleast 10 characters';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id, 
                    isFavourite: _editedProduct.isFavourite,
                    description: value, 
                    title: _editedProduct.title, 
                    price: _editedProduct.price, 
                    imageUrl: _editedProduct.imageUrl);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top:8, right:10,),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)
                  ),
                  child: _imageUrlController.text.isEmpty? Text('Enter a URL') : FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                      ),
                  ),
                ),
                Expanded(
                    child: TextFormField(
                    //initvalue for image url to set for controller not for form directly, done in did change dep function
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter a URL';
                      }
                      if(!value.startsWith('http') && !value.startsWith('https')){
                        return 'Please enter a valid URL';
                      }
                      if(!value.endsWith('png') && !value.endsWith('jpg') && !value.endsWith('jpeg')){
                        return 'Please enter a valid image URL';
                      }
                      return null;
                    },
                    onFieldSubmitted: (val){
                      _saveForm();
                    },
                    onSaved: (value){
                    _editedProduct = Product(
                      id: _editedProduct.id, 
                      isFavourite: _editedProduct.isFavourite,
                      description: _editedProduct.description, 
                      title: _editedProduct.title, 
                      price: _editedProduct.price, 
                      imageUrl: value);
                },
                  ),
                )
              ],)
            ],
          ),),
      ),
      );
  }
}