using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http;
using ZXing;

namespace MouseApi.Controllers
{
    public class QrCodeController : ApiController
    {
        private const int QR_CODES_PER_PAGE = 8;
        private const int QR_CODE_SCALE_X = 150;
        private const int QR_CODE_SCALE_Y = 150;

        private Document _document;
        private MemoryStream _outputStream;
        private PdfWriter _pdfWriter;
        private IEnumerable<KeyValuePair<string, string>> _queryStringParameters;
        private Color _qrCodeColor;
        private BarcodeWriter _barcodeWriter;

        public QrCodeController()
        {
            _document = new Document(PageSize.A4, 50, 50, 25, 25);
            _outputStream = new MemoryStream();
            _pdfWriter = PdfWriter.GetInstance(_document, _outputStream);     
            _qrCodeColor = default(Color);
            _barcodeWriter = new BarcodeWriter { Format = BarcodeFormat.QR_CODE };
        }


        [HttpGet]
        public HttpResponseMessage Get()
        {
            _queryStringParameters = Request.GetQueryNameValuePairs();

            _document.Open();

            for(int i =0; i < QR_CODES_PER_PAGE; i++)
            {
                var bitMap = _barcodeWriter.Write(Guid.NewGuid().ToString());

                if (TryGetColorParam(Request, out _qrCodeColor))
                {
                    bitMap = ColorImage(bitMap, _qrCodeColor);
                }

                var code = iTextSharp.text.Image.GetInstance(bitMap, ImageFormat.Bmp);

                code.SetAbsolutePosition(Positions[i].Item1, Positions[i].Item2);
                code.ScaleAbsolute(QR_CODE_SCALE_X, QR_CODE_SCALE_Y);
                _document.Add(code);
            }
            
            _document.Close();

            var buffer = _outputStream.ToArray();
            var contentLength = buffer.Length;

            var response = Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StreamContent(new MemoryStream(buffer));
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/pdf");
            response.Content.Headers.ContentLength = contentLength;

            return response;
        }

        /// <summary>
        /// A list containing the XY positions of the QR Codes.
        /// </summary>
        private List<Tuple<int, int>> Positions = new List<Tuple<int, int>>
        {
            new Tuple<int, int>(75, 250),
            new Tuple<int, int>(375, 250),
            new Tuple<int, int>(75, 450),
            new Tuple<int, int>(375, 450),
            new Tuple<int, int>(75, 650),
            new Tuple<int, int>(375, 650),
            new Tuple<int, int>(75, 50),
            new Tuple<int, int>(375, 50)
        };

        /// <summary>
        /// A dictionary mapping string values to colors. 
        /// </summary>
        private Dictionary<string, Color> AllowedColors = new Dictionary<string, Color>
        {
            {"green", Color.Green },
            {"blue", Color.Blue },
            {"red", Color.Red }
        };
        

        /// <summary>
        /// Colors the given QR Code Image.
        /// </summary>
        /// <param name="image">The QR Code Bitmap image.</param>
        /// <param name="color">The color to make the QR Code.</param>
        /// <returns>The colored QR Code Bitmap Image.</returns>
        private Bitmap ColorImage(Bitmap image, Color color)
        {
            for(int i = 0; i < image.Size.Height; i++)
            {
                for(int j = 0; j < image.Size.Width; j++)
                {
                    if (image.GetPixel(j, i) != Color.FromArgb(255, 255, 255, 255))
                    {
                        image.SetPixel(j, i, color);
                    }
                }
            }
            return image;
        }

        /// <summary>
        /// Extracts the color query string parameter
        /// </summary>
        /// <param name="request">The incoming <see cref="HttpRequestMessage"/>.</param>
        /// <param name="value">The value of the query string parameter.</param>
        /// <returns>True if the color parameter exists; false otherwise.</returns>
        private bool TryGetColorParam(HttpRequestMessage request, out Color value)
        {
            value = default(Color);
            var pairs = request.GetQueryNameValuePairs();

            foreach(var param in pairs)
            {
                if(param.Key.Equals("color"))
                {
                    return AllowedColors.TryGetValue(param.Value, out value);
                }
            }
            return false;
        }
    }
}