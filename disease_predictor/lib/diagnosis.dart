import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:disease_predictor/showdoctor.dart';

class ImageDiagnosisPage extends StatefulWidget {
  final File image;

  const ImageDiagnosisPage({Key? key, required this.image}) : super(key: key);

  @override
  _ImageDiagnosisPageState createState() => _ImageDiagnosisPageState();
}

class _ImageDiagnosisPageState extends State<ImageDiagnosisPage> {
  String _result = '';
  String _advice = '';

  @override
  void initState() {
    super.initState();
    _diagnoseImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Image Diagnosis'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Center(
              child: Image.file(
                widget.image,
                height: 210.0,
                width: 210.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(_result),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(_advice),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DermatologistPage()),
                  );*/
                },
                child: const Text('Consult a Doctor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _diagnoseImage(File image) async {
    try {
      const url = 'https://skinp.herokuapp.com/predict';
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      final response = await request.send();
      final output = await response.stream.bytesToString();

      print('response : $response');

      if (output!=null) {
        final decodedResponse = json.decode(output);
        final diagnosis = decodedResponse['disease_name'];
        final advice = decodedResponse['label'];

        // Update the UI with the diagnosis result
        setState(() {
          _result = 'Diagnosis: $diagnosis';


          switch (advice) {
            case 0:
              _advice =
              'Description: A skin condition causing red patches and visible blood vessels on the face. Very common. Treatments can help manage condition, no known cure. Rarely requires lab test or imaging. Common for ages 35-50. More common in females. Family history may increase likelihood';
              break;
            case 1:
              _advice =
              'Description: Basal cell carcinoma is a type of skin cancer. Basal cell carcinoma begins in the basal cells — a type of cell within the skin that produces new skin cells as old ones die off.Basal cell carcinoma often appears as a slightly transparent bump on the skin, though it can take other forms.';
              break;
            case 2:
              _advice =
              'Description: A group of skin conditions characterised by red, itchy rashes. Urgent medical attention is usually recommended in severe cases by healthcare providers Very common (More than 1 crore cases per year in India) Treatable by a medical professional Often requires lab test or imaging Time taken for recovery Can last several years or be lifelong Condition Highlight Family history may increase likelihood';
              break;
            case 3:
              _advice =
              'Description: Women of childbearing age have the highest risk for developing autoimmune bullous diseases.Symptoms:General symptoms may include:Bullae which are large blisters, thin-walled sacs filled with clear fluid have the symptoms - Multiple, Usually located on the arms, legs, or trunk, May also occur in the mouth, May weep, crust over, May appear deep below the surface of the skin, May erode the skin, form ulcers or open sores. Rashes. Mouth sores. Bleeding gums. Itching.';
              break;
            case 4:
              _advice =
              'Description: Impetigo (im-puh-TIE-go) is a common and highly contagious skin infection that mainly affects infants and young children. It usually appears as reddish sores on the face, especially around the nose and mouth and on the hands and feet. Over about a week, the sores burst and develop honey-colored crusts. Treatment with antibiotics can limit the spread of impetigo to others.';
              break;
            case 5:
              _advice =
              'Description: A group of skin conditions characterised by red, itchy rashes. Urgent medical attention is usually recommended in severe cases by healthcare providers. Very common (More than 1 crore cases per year in India). Treatable by a medical professional. Often requires lab test or imaging. Can last several years or be lifelong. Family history may increase likelihood';
              break;
            case 6:
              _advice =
              'Description: Exanthematous (maculopapular) drug eruptions usually begin 4 to 21 days after the responsible drug is started and rapidly evolve into widespread rash. Management includes stopping the drug, prescribing antipruritic therapy, and assessing the patient for severe cutaneous reaction.';
              break;
            case 7:
              _advice =
              'Description: Hair loss (alopecia) is a fairly common occurrence. While it’s more prevalent in older adults, anyone can experience it, including children. It’s typical to lose between 50 and 100 hairs a day, according to the American Academy of Dermatology (AAD). With about 100,000 hairs on your head, that small loss isn’t noticeable. New hair normally replaces the lost hair, but this doesn’t always happen.';
              break;
            case 8:
              _advice =
              'Description: Sexually transmitted diseases (STDs) — or sexually transmitted infections (STIs) — are generally acquired by sexual contact. The bacteria, viruses or parasites that cause sexually transmitted diseases may pass from person to person in blood, semen, or vaginal and other bodily fluids. Sometimes these infections can be transmitted nonsexually, such as from mothers to their infants during pregnancy or childbirth.';
              break;
            case 9:
              _advice =
              'Description: A skin pigmentation disorder is a condition that affects the color of the skin. Some common types of skin pigmentation disorders include albinism, melasma, vitiligo, and pigment changes from skin damage. The pigment melanin gives skin its color. It is made by specialized skin cells called melanocytes. When melanocytes become damaged, skin color can be affected.';
              break;
            case 10:
              _advice =
              'Description: Connective tissue diseases are actually a group of medical diseases. A connective tissue disease is any disease that has the connective tissues of the body as a primary target of pathology. The connective tissues are the structural portions of our body that essentially hold the cells of the body together. These tissues form a framework, or matrix, for the body.';
              break;
            case 11:
              _advice =
              'Description: Melanoma, the most serious type of skin cancer, develops in the cells (melanocytes) that produce melanin — the pigment that gives your skin its color. Melanoma can also form in your eyes and, rarely, inside your body, such as in your nose or throat. The exact cause of all melanomas isnt clear, but exposure to ultraviolet (UV) radiation from sunlight or tanning lamps and beds increases your risk of developing melanoma.';
              break;
            case 12:
              _advice =
              'Description: Nail fungus is a common infection of the nail. It begins as a white or yellow-brown spot under the tip of your fingernail or toenail. As the fungal infection goes deeper, the nail may discolor, thicken and crumble at the edge. Nail fungus can affect several nails. If your condition is mild and not bothering you, you may not need treatment. If your nail fungus is painful and has caused thickened nails, self-care steps and medications may help.';
              break;
            case 13:
              _advice =
              'Description: Poison ivy rash is caused by an allergic reaction to an oily resin called urushiol (u-ROO-she-ol). This oily resin is in the leaves, stems and roots of poison ivy, poison oak and poison sumac.  Wash your skin right away if you come into contact with this oil, unless you know youre not sensitive to it. Washing off the oil may reduce your chances of getting a poison ivy rash. If you develop a rash, it can be very itchy and last for weeks.';
              break;
            case 14:
              _advice =
              'Description: If you’ve noticed a rash on your body, it’s natural to be concerned. You should know that there are many skin conditions that can cause skin abnormalities. Two such conditions are psoriasis and lichen planus. Psoriasis is a chronic skin condition, and outbreaks can appear just about anywhere on the body. Lichen planus also manifests on the skin, but is typically found on the inside of the mouth.';
              break;
            case 15:
              _advice =
              'Description: Human scabies is a parasitic infestation caused by Sarcoptes scabiei var hominis. The microscopic mite burrows into the skin and lays eggs, eventually triggering a host immune response that leads to intense itching and rash. Scabies infestation may be complicated by bacterial infection, leading to the development of skin sores that, in turn, may lead to the development of more serious consequences such as septicaemia, heart disease and chronic kidney disease.';
              break;
            case 16:
              _advice =
              'Description: A seborrheic keratosis (seb-o-REE-ik ker-uh-TOE-sis) is a common noncancerous (benign) skin growth. People tend to get more of them as they get older. Seborrheic keratoses are usually brown, black or light tan. The growths (lesions) look waxy or scaly and slightly raised. They appear gradually, usually on the face, neck, chest or back. Seborrheic keratoses are harmless and not contagious.';
              break;
            case 17:
              _advice =
              'Description: A systemic disease is one that harms a number of organs and tissues or harms the body as a whole. Systemic diseases harm the entire body. The hands, being composed of many types of tissue, including blood vessels, nerves, skin and skin-related tissues, bones, and muscles/tendons/ligaments, may look changes that reflect a disease that affects other areas of, or even the whole body (systemic disease).';
              break;
            case 18:
              _advice =
              'Description: Ringworm. Ringworm, candida, jock itch, and tinea versicolor are just a few examples of fungal skin infections. Topical or oral antifungal medications are used for treatment. Pool areas, locker rooms, public showers, and other areas prone to dampness are prime locations to pick up a fungal skin infection.';
              break;
            case 19:
              _advice =
              'Description: A skin rash with red itchy bumps as a result of allergic reactions of the body. Very common (More than 1 crore cases per year in India). Treatable by a medical professional. Requires lab test or imaging. Can last several months or years. Family history may increase likelihood';
              break;
            case 20:
              _advice =
              'Description: Vascular tumors are a rare subset of vascular anomalies. These are classified based on their malignant potential or local destruction potential. Classification has been historically difficult and treatment recommendations are based on case series. The purpose of this chapter is to review the presentation, pathologic and imaging characteristics. Treatment recommendations are summarized based on the current literature.';
              break;
            case 21:
              _advice =
              'Description: A group of conditions characterised by the inflammation of blood vessels. This causes headache, fatigue and fever. Urgent medical attention is usually recommended in severe cases by healthcare providers. May be dangerous or life threatening. Rare (Fewer than 10 lakh cases per year in India). Treatable by a medical professional. Often requires lab test or imaging. Can last several years or be lifelong';
              break;
            case 22:
              _advice =
              'Description: Molluscum contagiosum (mo-LUS-kum kun-tay-jee-OH-sum) is a fairly common skin infection caused by a virus. It causes round, firm, painless bumps ranging in size from a pinhead to a pencil eraser. If the bumps are scratched or injured, the infection can spread to nearby skin. Molluscum contagiosum also spreads through person-to-person contact and contact with infected objects.';
              break;
          }
        });
      } else {
        setState(() {
          _result = 'Error: Select a valid Photo';
          _advice = '';
        });
      }
    } catch (e) {
      // Handle errors
      setState(() {
        _result = 'Error: ${e.toString()}';
        _advice = '';
      });
    }
  }
}
