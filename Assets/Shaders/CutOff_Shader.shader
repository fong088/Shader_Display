Shader "ACG/TextureWithBlackStripes"
{
    Properties{
        _MainTex("Main Texture", 2D) = "white" {}
        _stripeRange("Stripe Amount", Range(0,10)) = 0.5
    }

    SubShader{
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input{
            float2 uv_MainTex;
            float3 worldPos;
        };

        sampler2D _MainTex;
        half _stripeRange;

        void surf (Input IN, inout SurfaceOutput o){
            
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex);
            float mask = frac(IN.worldPos.y * _stripeRange) < 0.5 ? 1.0 : 0.0;
            o.Albedo = texColor.rgb * mask;

            // Mantener alpha de la textura
            //o.Alpha = texColor.a;
        }
        ENDCG
    }
}
