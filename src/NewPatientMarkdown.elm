module NewPatientMarkdown exposing (..)

import Html
import Markdown.Parser as Markdown
import Markdown.Renderer


markdownBody =
    """
## Dr. Doug’s Pediatric Dentistry Policies

### Adult Supervision

All children under the age of 16 must have an adult with them unless arrangements have been made with our office before the appointment. 

### Missed, Canceled, or Changed appointments

In order to make things pleasant for your child(ren) Dr. Doug works extremely fast and keeps appointments as short as possible. As a result, we ask that you arrive on time for your appointment. Patients arriving **10 minutes** late will be considered missed and rescheduled for a later date. We require a 24-hour notice to cancel or change appointments without a $15 fee.

### Insurance

You are responsible for providing an updated, and active insurance card at the time of your appointment. If no card is given at the time of the visit, or the insurance is invalid, a late claim-filing fee of $15 may be charged to you. If our office doesn’t have your insurance information at the time of your appointment, you will need to pay for the services rendered and it will be your responsibility to bill your insurance for reimbursement.

All quotes given by our office are **estimates** of what your insurance will pay towards your visit. For exact amounts, contact your insurance directly. **Fees estimated to not be covered by insurance will be due in full at the time of service.**

### Treatment Payments

In consideration for the professional services to be rendered to me, or at my request, to my minor child or ward by the dentist, I agree to pay the fees charges for the dental services provided to the dentist or his/her assignee at the time the services are rendered, or within (5) days of billing if credit should be extended. I agree to pay the remaining balance along with a collection agency commission. Should your account be turned over for collection, the undersigned agrees to pay all costs to collect the debt, including, but not limited to, interest in the amount of 18% per annum, attorney’s fees, court costs, and collection fees in the amount of 40%. The obligation to pay the collection fees shall be imposed at the time of assignment of the debt to a third-party debt collection agency. **The undersigned certifies that he/she has read and understands the foregoing disclosure.**

### Your Rights Regarding Your Health Information

A copy of your privacy rights is available at the counter. If you would like a copy to take with you, please ask and we would be happy to get you a copy.

- I acknowledge that I have been offered or received a copy of Dr. Doug’s Notice of Privacy Practices.
- I give consent for this patient to receive treatment in an oral exam today and any possible treatment that might be proposed in the future by the office of Dr. Doug’s Pediatric Dentistry.
- I give consent for the use and disclosure of any protected health information that may be used to carry out treatment, payment activities, and healthcare operations.
- I have read and understand all the above information.
"""


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.deadEndToString
        |> String.join "\n"


renderMarkdown : Html.Html msg
renderMarkdown =
    Html.div
        []
        [ case
            markdownBody
                |> Markdown.parse
                |> Result.mapError deadEndsToString
                |> Result.andThen (\ast -> Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer ast)
          of
            Ok rendered ->
                Html.div [] rendered

            Err errors ->
                Html.text errors
        ]
