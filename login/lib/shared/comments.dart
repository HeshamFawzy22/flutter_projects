// if (!FirebaseAuth.instance.currentUser!.emailVerified)
//   Container(
//     color: Colors.amber.withOpacity(.6),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Row(
//         children: [
//           const Icon(Icons.info_outline),
//           const SizedBox(
//             width: 15.0,
//           ),
//           const Text('Please verify your email'),
//           const Spacer(),
//           defaultTextButton(
//             onPressed: () {
//               FirebaseAuth.instance.currentUser
//                   ?.sendEmailVerification()
//                   .then((value) {
//                 showToast(
//                     msg: 'Check your email',
//                     state: ToastStates.SUCCESS);
//               })
//                   .catchError((error) {});
//             },
//             text: 'Send',
//           ),
//         ],
//       ),
//     ),
//   )
